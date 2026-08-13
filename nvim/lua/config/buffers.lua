local M = {}

local function delete_buffer(buf, force)
	if Snacks and Snacks.bufdelete then
		Snacks.bufdelete({ buf = buf, force = force })
	else
		vim.api.nvim_buf_delete(buf, { force = force })
	end
end

local function write_buffer(buf, callback)
	local name = vim.api.nvim_buf_get_name(buf)
	local function write(path)
		if path and path ~= "" then
			local ok, err = pcall(vim.api.nvim_buf_call, buf, function()
				if name == "" then
					vim.cmd.write(vim.fn.fnameescape(path))
				else
					vim.cmd.write()
				end
			end)
			if not ok then
				vim.notify("Não foi possível salvar o buffer:\n" .. tostring(err), vim.log.levels.ERROR)
			end
			callback(ok)
		else
			vim.notify("Fechamento cancelado: informe um nome para salvar o buffer.", vim.log.levels.INFO)
			callback(false)
		end
	end

	if name == "" then
		vim.ui.input({ prompt = "Salvar buffer como: ", completion = "file" }, write)
	else
		write(name)
	end
end

---@param buf number
---@param callback? fun(closed: boolean)
function M.close(buf, callback)
	callback = callback or function() end
	buf = buf or vim.api.nvim_get_current_buf()
	if not vim.api.nvim_buf_is_valid(buf) then
		callback(true)
		return
	end

	if not vim.bo[buf].modified then
		delete_buffer(buf, false)
		callback(true)
		return
	end

	local label = vim.api.nvim_buf_get_name(buf)
	label = label == "" and "[Sem nome]" or vim.fn.fnamemodify(label, ":~:.")
	vim.ui.select({ "Salvar", "Descartar", "Cancelar" }, {
		prompt = "O buffer " .. label .. " possui alterações:",
	}, function(choice)
		if choice == "Salvar" then
			write_buffer(buf, function(written)
				if written then
					delete_buffer(buf, false)
				end
				callback(written)
			end)
		elseif choice == "Descartar" then
			delete_buffer(buf, true)
			callback(true)
		else
			vim.notify("Fechamento cancelado; o conteúdo foi preservado.", vim.log.levels.INFO)
			callback(false)
		end
	end)
end

function M.close_others()
	local current = vim.api.nvim_get_current_buf()
	local buffers = vim.tbl_filter(function(buf)
		return buf ~= current and vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted
	end, vim.api.nvim_list_bufs())

	local function close_next(index)
		if index > #buffers then
			return
		end
		M.close(buffers[index], function(closed)
			if closed then
				close_next(index + 1)
			end
		end)
	end

	close_next(1)
end

return M

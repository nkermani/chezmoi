local status_ok, remote_ssh = pcall(require, "remote-ssh")
if not status_ok then return end

local tel_remote_ok, tel_remote = pcall(require, "telescope-remote-buffer")
if tel_remote_ok then
    tel_remote.setup()
else
    print("Avertissement: telescope-remote-buffer non chargé")
end

remote_ssh.setup({
    filetype_to_server = {
        python = "pylsp",
        cpp = "clangd",
    }
})


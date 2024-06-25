require("dapui").setup()

local dap = require('dap')
local dapui = require("dapui")

dap.listeners.before.attach.dapui_config = function()
    dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
    dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
end

require("mason-nvim-dap").setup({
    handlers = {
        function(config)
            require("mason-nvim-dap").default_setup(config)
        end,
        codelldb = function(config)
            config.adapters = {
                type = 'server',
                port = "${port}",
                -- host = '127.0.0.1',
                -- port = 13000

                executable = {
                    command = 'codelldb',
                    args = { "--port", "${port}" },

                    -- On windows you may have to uncomment this:
                    -- detached = false,
                }
            }
        end

    }
})

dap.adapters.cppdbg = {
    id = 'cppdbg',
    type = 'executable',
    --command = '/absolute/path/to/cpptools/extension/debugAdapters/bin/OpenDebugAD7',
    command = 'OpenDebugAD7'
}
dap.adapters.coreclr = {
    type = 'executable',
    command = '/usr/local/netcoredbg',
    args = { '--interpreter=vscode' }
}
dap.adapters.gdb = {
    type = "executable",
    command = "gdb",
    args = { "-i", "dap" }
}

--------------------
-- Configurations --
--------------------

-- dap.configurations.rust = {
--     {
--         name = "Launch file",
--         type = "codelldb",
--         request = "launch",
--         program = function()
--             return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug', 'file')
--         end,
--         cwd = '${workspaceFolder}',
--         stopOnEntry = false
--     },
-- }

-- dap.configurations.c = {
--     {
--         name = "Enter executable to launch",
--         type = "codelldb",
--         request = "launch",
--         program = function()
--             return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
--         end,
--         cwd = '${workspaceFolder}',
--         stopAtEntry = true,
--         terminal = 'integrated'
--     },
-- }

dap.configurations.rust = {
    {
        name = "Launch",
        type = "gdb",
        request = "launch",
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug', 'file')
        end,
        cwd = "${workspaceFolder}",
        stopAtBeginningOfMainSubprogram = false,
    },
}

dap.configurations.c = {
    {
        name = "Launch",
        type = "gdb",
        request = "launch",
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = "${workspaceFolder}",
        stopAtBeginningOfMainSubprogram = false,
    },
}

dap.configurations.cpp = dap.configurations.c

dap.configurations.cs = {
    {
        name = "launch - netcoredbg",
        type = "coreclr",
        request = "launch",
        program = function()
            return vim.fn.input("Path to dll", vim.fn.getcwd() .. '/bin/Debug/', 'file')
        end,
    },
}

dap.configurations.java = {
    {
        type = 'java',
        request = 'launch',
        name = 'debug current java file',

        mainClass = "${fileBasenameNoExtension}",
        javaExec = "/usr/bin/java",
    }
}

-- Function to load configurations from .dap.json
local function load_dap_configurations()
    local dap_json_path = vim.fn.getcwd() .. '/.dap.json'

    -- Check if the .dap.json file exists and is readable
    if vim.fn.filereadable(dap_json_path) == 0 then
        -- print(".dap.json file not found or not readable in the current directory")
        return
    end

    local status, dap_json = pcall(function()
        return vim.fn.json_decode(vim.fn.readfile(dap_json_path))
    end)

    -- Check if JSON decoding was successful
    if not status then
        print("Error reading .dap.json: Invalid JSON format")
        return
    end

    -- Check if configurations key exists and is a table
    if not dap_json.configurations or type(dap_json.configurations) ~= "table" then
        print(".dap.json does not contain valid 'configurations' table")
        return
    end

    for lang, configs in pairs(dap_json.configurations) do
        -- Initialize the configuration type table if it does not exist
        dap.configurations[lang] = dap.configurations[lang] or {}

        for _, config in ipairs(configs) do
            -- Validate required configuration keys
            if not (config.name and config.type and config.request) then
                print("One or more configurations are missing required keys (name, type, request)")
                return
            end

            -- Add the configuration to the appropriate language type
            table.insert(dap.configurations[lang], config)
        end
    end
end

-- Load the configurations
load_dap_configurations()

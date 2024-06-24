return {
    "mfussenegger/nvim-dap",
    "jay-babu/mason-nvim-dap.nvim",
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" }
    },
    config = function()
        require("mason-nvim-dap").setup()
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

        -- Adapters --
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
        dap.adapters.codelldb = {
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
        dap.adapters.python = {
            type = "executable",
            command = "debugpy-adapter",
            -- stdpath("run") .. "/mason/packages/debugpy/venv/bin/python3"

            -- command = "/usr/bin/python3",
            --     -- args = {
            --     --     "-m",
            --     --     "debugpy.adapter"
            --     -- }
        }

        -- dap.adapters.python = function(cb, config)
        --     if config.request == 'attach' then
        --         ---@diagnostic disable-next-line: undefined-field
        --         local port = (config.connect or config).port
        --         ---@diagnostic disable-next-line: undefined-field
        --         local host = (config.connect or config).host or '127.0.0.1'
        --         cb({
        --             type = 'server',
        --             port = assert(port, '`connect.port` is required for a python `attach` configuration'),
        --             host = host,
        --             options = {
        --                 source_filetype = 'python',
        --             },
        --         })
        --     else
        --         cb({
        --             type = 'executable',
        --             -- command = 'path/to/virtualenvs/debugpy/bin/python',
        --             command = 'debugpy',
        --             args = { '-m', 'debugpy.adapter' },
        --             options = {
        --                 source_filetype = 'python',
        --             },
        --         })
        --     end
        -- end

        -- Configurations --

        dap.configurations.rust = {
            -- {
            --     name = "Launch file",
            --     type = "codelldb",
            --     request = "launch",
            --     program = function()
            --         return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug', 'file')
            --     end,
            --     cwd = '${workspaceFolder}',
            --     stopOnEntry = false
            -- },
            -- {
            --     name = "Debug tests",
            --     type = "codelldb",
            --     request = "launch"
            -- },
        }

        dap.configurations.c = {
            {
                name = "Enter executable to launch",
                type = "codelldb",
                request = "launch",
                program = function()
                    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                cwd = '${workspaceFolder}',
                stopAtEntry = true,
                terminal = 'integrated'
            },
            -- {
            --     name = 'Attach to gdbserver :8040',
            --     type = 'cppdbg',
            --     request = 'launch',
            --     MIMode = 'gdb',
            --     miDebuggerServerAddress = 'localhost:8040',
            --     miDebuggerPath = '/usr/bin/gdb',
            --     cwd = '${workspaceFolder}',
            --     program = function()
            --         return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            --     end,
            -- },
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
        dap.configurations.python = {
            {
                -- The first three options are required by nvim-dap
                type = 'python', -- the type here established the link to the adapter definition: `dap.adapters.python`
                request = 'launch',
                name = "Launch file",

                -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

                program = "${file}", -- This configuration will launch the current file if used.
                -- pythonPath = function()
                --     -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
                --     -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
                --     -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
                --     local cwd = vim.fn.getcwd()
                --     if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
                --         return cwd .. '/venv/bin/python'
                --     elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
                --         return cwd .. '/.venv/bin/python'
                --     else
                --         return '/usr/bin/python'
                --     end
                -- end,
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
    end
}

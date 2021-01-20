local map = require("settings.utils").map
local g = vim.g
local fn = vim.fn


g.ascii = {
  '                                                                  ',
  '                                                                  ',
  '                                                                  ',
  '                                                                  ',
  '                                                                  ',
  '  _|      _|  _|_|_|_|    _|_|    _|      _|  _|_|_|  _|      _|  ',
  '  _|_|    _|  _|        _|    _|  _|      _|    _|    _|_|  _|_|  ',
  '  _|  _|  _|  _|_|_|    _|    _|  _|      _|    _|    _|  _|  _|  ',
  '  _|    _|_|  _|        _|    _|    _|  _|      _|    _|      _|  ',
  '  _|      _|  _|_|_|_|    _|_|        _|      _|_|_|  _|      _|  ',
  '                                                                  ',
  '                                                                  ',
  '                                                                  ',
  '                                                                  ',
  '                                                                  ',
}



g.startify_custom_header = 'startify#center(g:ascii)'


g.startify_lists = {
   { type ='sessions',                    header = {'       Sessions' }           },
   { type ='files',                       header = {'       Files'    }           },
   { type ='dir',                         header = {'       Current Directory'}   },
   { type ='bookmarks',                   header = {'       Bookmarks'}           },
 }

local configPath = fn.stdpath('config') .. "/init.lua";
g.startify_bookmarks = {
        {i = configPath},
        }

g.startify_session_sort = 1
g.startify_session_autoload = 1
g.startify_session_delete_buffers = 1
g.startify_session_persistence = 1
g.startify_change_to_vcs_root = 1
g.startify_padding_left = 5
g.webdevicons_enable_startify = 1
g.startify_enable_special = 0
g.startify_files_number = 12
g.startify_update_oldfiles = 1
g.startify_change_to_vcs_root = 1
g.startify_change_to_dir = 1

map("n", "<leader>ss", ":SSave<cr>")
map("n", "<leader>sl", ":SLoad<cr>")
map("n", "<leader>sc", ":SClose<cr>")

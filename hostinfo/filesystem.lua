local HostInfo = require('./base').HostInfo

local sigarCtx = require('/sigar').ctx
local sigarutil = require('/base/util/sigar')

local table = require('table')

--[[ Filesystem Info ]]--
local FilesystemInfo = HostInfo:extend()
function FilesystemInfo:initialize()
  HostInfo.initialize(self)
  local fses = sigarCtx:filesystems()
  for i=1, #fses do
    local obj = {}
    local fs = fses[i]
    local info = fs:info()
    local usage = fs:usage()
    if info then
      local info_fields = {
        'dir_name',
        'dev_name',
        'sys_type_name',
        'options',
      }
      for _, v in pairs(info_fields) do
        obj[v] = info[v]
      end
    end

    if usage then
      local usage_fields = {
        'total',
        'free',
        'used',
        'avail',
        'files',
        'free_files',
      }
      for _, v in pairs(usage_fields) do
        obj[v] = usage[v]
      end
    end

    table.insert(self._params, obj)
  end
end

local exports = {}
exports.FilesystemInfo = FilesystemInfo
return exports

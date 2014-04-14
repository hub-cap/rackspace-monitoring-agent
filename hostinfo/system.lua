local HostInfo = require('./base').HostInfo

local sigarCtx = require('/sigar').ctx
local sigarutil = require('/base/util/sigar')

local table = require('table')


--[[ System Info ]]--
local SystemInfo = HostInfo:extend()
function SystemInfo:initialize()
  HostInfo.initialize(self)
  local sysinfo = sigarCtx:sysinfo()
  local obj = {name = sysinfo.name, arch = sysinfo.arch,
               version = sysinfo.version, vendor = sysinfo.vendor,
               vendor_version = sysinfo.vendor_version,
               vendor_name = sysinfo.vendor_name or sysinfo.vendor_version}

  table.insert(self._params, obj)
end

local exports = {}
exports.SystemInfo = SystemInfo
return exports

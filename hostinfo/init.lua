local Object = require('core').Object
local JSON = require('json')

local fs = require('fs')
local misc = require('/base/util/misc')
local os = require('os')
local table = require('table')
local vutils = require('virgo_utils')

local sigarCtx = require('/sigar').ctx
local sigarutil = require('/base/util/sigar')

local HostInfo = require('./base').HostInfo
local CPUInfo = require('./cpu').CPUInfo
local DiskInfo = require('./disk').DiskInfo
local FilesystemInfo = require('./filesystem').FilesystemInfo
local MemoryInfo = require('./memory').MemoryInfo
local NetworkInfo = require('./network').NetworkInfo
local NilInfo = require('./nil').NilInfo
local ProcessInfo = require('./procs').ProcessInfo
local SystemInfo = require('./system').SystemInfo
local WhoInfo = require('./who').WhoInfo


local HOST_INFO_MAP = {
  ["CPU"] = CPUInfo,
  ["MEMORY"] = MemoryInfo,
  ["NETWORK"] = NetworkInfo,
  ["DISK"] = DiskInfo,
  ["PROCS"] = ProcessInfo,
  ["FILESYSTEM"] = FilesystemInfo,
  ["SYSTEM"] = SystemInfo,
  ["WHO"] = WhoInfo
}

--[[ Factory ]]--
local function create(infoType)
  local klass = HOST_INFO_MAP[infoType]
  if klass then
    return klass:new()
  end
  return NilInfo:new()
end

-- Dump all the info objects to a file
local function debugInfo(fileName, callback)
  local data = ''
  for k, v in pairs(HOST_INFO_MAP) do
    local info = create(v)
    local obj = info:serialize().metrics
    data = data .. '-- ' .. v .. '.' .. os.type() .. ' --\n\n'
    data = data .. misc.toString(obj)
    data = data .. '\n'
  end
  fs.writeFile(fileName, data, callback)
end

--[[ Exports ]]--
local exports = {}
exports.create = create
exports.debugInfo = debugInfo
return exports

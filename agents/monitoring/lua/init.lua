--[[
Copyright 2012 Rackspace

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS-IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
--]]

local logging = require('logging')

local Entry = {}

local argv = require("options")
  .usage("Usage: ")
  .describe("n", "Do not verify Zip Bundle.")
  .describe("e", "entry module")
  .describe("s", "state directory path")
  .argv("ne:s:")

function Entry.run()
  local mod = argv.args.e or 'monitoring-agent'
  mod = './' .. mod

  local verify = not argv.args.n

  logging.log(logging.INFO, 'Running Module ' .. mod)

  local err, msg = pcall(function()
    require(mod).run({stateDirectory = argv.args.s, verify = verify})
  end)

  if err == false then
    logging.log(logging.ERR, msg)
  end
end

return Entry

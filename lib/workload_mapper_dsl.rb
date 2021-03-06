# Copyright (c) 2013-2016 SUSE LLC
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of version 3 of the GNU General Public License as
# published by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.   See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, contact SUSE LLC.
#
# To contact SUSE about this file by physical or electronic mail,
# you may find current contact information at www.suse.com
class WorkloadMapperDSL
  attr_reader :system, :name, :service, :parameters, :data

  def initialize(system)
    @system = system
    @parameters = {}
    @data = {}
  end

  def identify(name, service = nil)
    @name = name
    @service = !!service ? service : name
  end

  def parameter(name, value)
    @parameters[name] = value
  end

  def extract(origin, destination)
    @data[origin] = destination
  end

  def to_h
    return {} unless service
    {
      name => {
        "service" => service,
        "parameters" => parameters,
        "data" => data
      }
    }
  end

  def check_clue(clue)
    instance_eval(clue)
    self
  end
end

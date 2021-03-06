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

class Migrate1To2 < Migration
  desc <<-EOT
    Schema version 2 introduces an "extracted" flag for the config_files,
    changed_managed_files and unmanaged_files scope, indicating whether the
    files were extracted or not.

    It also introduces a "remote_dir" type for the unmanaged_files scope
    indicating that the directory is a remote mount point and that the
    content is not checked or extracted.

    Add the missing GID key for NIS placeholder entries in groups.
  EOT

  def migrate
    [
      "config_files",
      "changed_managed_files",
      "unmanaged_files"
    ].each do |scope|
      next unless @hash.key?(scope)

      files = @hash[scope]
      is_extracted = Dir.exist?(File.join(@path, scope))

      @hash[scope] = {
        "extracted" => is_extracted,
        "files"     => files
      }
    end

    if @hash.key?("groups")
      @hash["groups"].each do |element|
        unless element["gid"]
          element["gid"] = nil
        end
      end
    end
  end
end

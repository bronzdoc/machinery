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

def number_to_human_size(s)
  unit = %W(B KiB MiB GiB TiB)
  i = s.to_i

  exp = i != 0 ? Math.log(i, 1024).floor : 0
  value = (i / 1024.0 ** exp).round(1)

  "#{"%g" % value} #{unit[exp]}"
end

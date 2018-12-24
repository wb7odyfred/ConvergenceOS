#
# Copyright (C) 2018  Jonathan Railsback
#
# This file is part of ConvergenceOS.
#
# ConvergenceOS is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2 as
# published by the Free Software Foundation
#
# ConvergenceOS is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with ConvergenceOS.  If not, see <https://www.gnu.org/licenses/>.
#
import argparse


def main(driver_string):

    driver_string = driver_string.upper()

    if 'NOUVEAU' in driver_string:
        driver_id = 'NOUVEAU'
    elif 'MESA' in driver_string:
        driver_id = 'MESA'
    elif 'NVIDIA' in driver_string:
        driver_id = 'NVIDIA_PROPIETARY'
    else:
        driver_id = 'UNKNOWN'

    print(driver_id)


if __name__ == '__main__':

    arg_parser = argparse.ArgumentParser()
    arg_parser.add_argument('driver_string')
    args = arg_parser.parse_args()

    driver_string = args.driver_string

    main(driver_string)

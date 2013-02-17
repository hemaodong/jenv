#!/bin/bash

#
#   Copyright 2012 Jacky Chan
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
#

function __jenvtool_uninstall {
	CANDIDATE="$1"
	VERSION="$2"
	__jenvtool_check_candidate_present "${CANDIDATE}" || return 1
	__jenvtool_check_version_present "${VERSION}" || return 1
	CURRENT=$(readlink "${JENV_DIR}/${CANDIDATE}/current" | sed -e "s_${JENV_DIR}/${CANDIDATE}/__g")
	if [[ -h "${JENV_DIR}/${CANDIDATE}/current" && ( "${VERSION}" == "${CURRENT}" ) ]]; then
		echo ""
		echo "Unselecting ${CANDIDATE} ${VERSION}..."
		unlink "${JENV_DIR}/${CANDIDATE}/current"
	fi
	echo ""
	if [ -d "${JENV_DIR}/${CANDIDATE}/${VERSION}" ]; then
		echo "Uninstalling ${CANDIDATE} ${VERSION}..."
		rm -rf "${JENV_DIR}/${CANDIDATE}/${VERSION}"
	else
		echo "${CANDIDATE} ${VERSION} is not installed."
	fi
}

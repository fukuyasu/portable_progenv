#
# ProGENv-git: Portable Programming Environment - MinGit
#

########################################################################

#
# ファイル／ディレクトリ構造
#   ${BASE_DIR}
#       +- MinGit : ${GIT_DIR}
#       +- clinit-70-mingit.bat
#

GIT_DIR = MinGit

CLINIT_GIT_SRC = clinit-70-git.src
CLINIT_GIT_BAT = clinit-70-git.bat

########################################################################

GIT_VERSION = 2.49.0
MINGIT_ZIP = ${DIST_DIR}/MinGit-${GIT_VERSION}-busybox-64-bit.zip
# Download from https://github.com/git-for-windows/git/releases/
# https://github.com/git-for-windows/git/releases/download/v2.49.0.windows.1/MinGit-2.49.0-busybox-64-bit.zip

########################################################################

git: ${BASE_DIR}/${CLINIT_GIT_BAT}

${BASE_DIR}/${GIT_DIR}/cmd/git.exe:
	${MAKE} ${MAKE_FLAGS} ${BASE_DIR} 
	${7Z} x ${MINGIT_ZIP} -o${BASE_DIR}/${GIT_DIR}

${BASE_DIR}/${CLINIT_GIT_BAT}: ${CLINIT_GIT_SRC}
	${MAKE} ${MAKE_FLAGS} cl
	${MAKE} ${MAKE_FLAGS} ${BASE_DIR}/${GIT_DIR}/cmd/git.exe 
	${RM} ${BASE_DIR}/${CLINIT_GIT_BAT}
	${CAT} ${CLINIT_GIT_SRC} \
	    | ${SED} -e 's|__GIT_DIR__|${GIT_DIR}|g' \
	    > ${BASE_DIR}/${CLINIT_GIT_BAT}

########################################################################

clean::
	${RM} ${BASE_DIR}/${CLINIT_GIT_BAT}

clean::
	${RM} -R ${BASE_DIR}/${GIT_DIR}

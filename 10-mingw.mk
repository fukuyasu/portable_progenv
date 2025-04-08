#
# ProGENv-mingw: Portable Programming Environment - MinGW-w64
#

########################################################################

#
# ファイル／ディレクトリ構造
#   ${BASE_DIR}
#       +- mingw64 : ${MINGW_DIR}
#       +- clinit-10-mingw.bat
#

MINGW_DIR = mingw64

CLINIT_MINGW_SRC = clinit-10-mingw.src
CLINIT_MINGW_BAT = clinit-10-mingw.bat

########################################################################

MINGW_VERSION = 14.2.0
MINGW_THREADS = win32
MINGW_EXCEPTION = seh
MINGW_CRT = ucrt
MINGW_RT = rt_v12
MINGW_REVISION = 2
MINGW_ZIP = ${DIST_DIR}/x86_64-${MINGW_VERSION}-release-${MINGW_THREADS}-${MINGW_EXCEPTION}-${MINGW_CRT}-${MINGW_RT}-rev${MINGW_REVISION}.7z
# Download from https://github.com/niXman/mingw-builds-binaries/releases
# https://github.com/niXman/mingw-builds-binaries/releases/download/14.2.0-rt_v12-rev2/x86_64-14.2.0-release-win32-seh-ucrt-rt_v12-rev2.7z

########################################################################

mingw: ${BASE_DIR}/${CLINIT_MINGW_BAT}

${BASE_DIR}/${MINGW_DIR}/bin/gcc.exe:
	${MAKE} ${MAKE_FLAGS} ${BASE_DIR} 
	${7Z} x ${MINGW_ZIP} -o${BASE_DIR}

${BASE_DIR}/${CLINIT_MINGW_BAT}: ${CLINIT_MINGW_SRC}
	${MAKE} ${MAKE_FLAGS} cl
	${MAKE} ${MAKE_FLAGS} ${BASE_DIR}/${MINGW_DIR}/bin/gcc.exe 
	${RM} ${BASE_DIR}/${CLINIT_MINGW_BAT}
	${CAT} ${CLINIT_MINGW_SRC} \
	    | ${SED} -e 's|__MINGW_DIR__|${MINGW_DIR}|g' \
	    > ${BASE_DIR}/${CLINIT_MINGW_BAT}

########################################################################

clean::
	${RM} ${BASE_DIR}/${CLINIT_MINGW_BAT}

clean::
	${RM} -R ${BASE_DIR}/${MINGW_DIR}

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

MINGW_VERSION = 8.1.0
MINGW_THREADS = posix
MINGW_EXCEPTION = seh
MINGW_REVISION = 0
MINGW_ZIP = ${DIST_DIR}/x86_64-${MINGW_VERSION}-release-${MINGW_THREADS}-${MINGW_EXCEPTION}-rt_v6-rev${MINGW_REVISION}.7z
# Download from https://sourceforge.net/projects/mingw-w64/files/
# https://sourceforge.net/projects/mingw-w64/files/Toolchains%20targetting%20Win64/Personal%20Builds/mingw-builds/8.1.0/threads-posix/seh/

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

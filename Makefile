#
# ProGENv: Portable Programming Environment
#

# Project name
PROJECT = progenv
# Project Title
TITLE   = ProGENv: Portable Programming Environment
# Project ver. num.
VERSION = 1.0

# Command-Line ver. num.
CL_VERSION = 1.0

########################################################################

#
# ファイル／ディレクトリ構造
#   progenv : ${BASE_DIR}
#       +- work : ${WORK_DIR} 
#       +- progenv command-line.lnk
#       +- clinit.bat
#

BASE_DIR = progenv
WORK_DIR = work

CL_SRC = progenv\ command-line.lnk
CL_LNK = ${CL_SRC}

CLINIT_SRC = clinit.src
CLINIT_BAT = clinit.bat

########################################################################

RELEASE_DIR = ../release
DIST_DIR    = ../distfiles

########################################################################

#
# 配布用アーカイブファイル
#

RELEASE_ZIP = ${RELEASE_DIR}/${PROJECT}-${VERSION}.`date "+%Y%m%d"`.zip

########################################################################

7Z       = /c/Program\ Files/7-Zip/7z
EXTRAC32 = /c/WINDOWS/system32/extrac32
ATTRIB   = /c/WINDOWS/system32/attrib

RM       = /bin/rm -f
CP       = /bin/cp -p
MV       = /bin/mv
MKDIR    = /bin/mkdir -p
CAT      = /bin/cat
SED      = /bin/sed
FIND     = /bin/find
SHELL    = /bin/sh

########################################################################

all: cl mingw

zip-all: all
	${7Z} a ${RELEASE_ZIP} ${BASE_DIR}

########################################################################

cl: ${BASE_DIR}/${CL_LNK}

${BASE_DIR}:
	${MKDIR} ${BASE_DIR}

${BASE_DIR}/${WORK_DIR}:
	${MKDIR} ${BASE_DIR}/${WORK_DIR}

${BASE_DIR}/${CLINIT_BAT}: ${CLINIT_SRC}
	${MAKE} ${MAKE_FLAGS} ${BASE_DIR}
	${MAKE} ${MAKE_FLAGS} ${BASE_DIR}/${WORK_DIR}
	${RM} ${BASE_DIR}/${CLINIT_BAT}
	${CAT} ${CLINIT_SRC} \
	    | ${SED} -e 's|__VERSION__|${CL_VERSION}|g' \
	             -e 's|__TITLE__|${TITLE}|g' \
	             -e 's|__WORK_DIR__|${WORK_DIR}|g' \
	    > ${BASE_DIR}/${CLINIT_BAT}

${BASE_DIR}/${CL_LNK}: ${CL_SRC}
	${MAKE} ${MAKE_FLAGS} ${BASE_DIR}
	${MAKE} ${MAKE_FLAGS} ${BASE_DIR}/${CLINIT_BAT}
	${CP} ${CL_SRC} ${BASE_DIR}

########################################################################

include *.mk

########################################################################

clean::
	${RM} ${BASE_DIR}/${CL_LNK}
	${RM} ${BASE_DIR}/${CLINIT_BAT}

clean::
	${RM} -R ${BASE_DIR}/${WORK_DIR}
	${RM} -R ${BASE_DIR}

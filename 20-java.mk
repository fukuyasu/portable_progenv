#
# ProGENv-java: Portable Programming Environment - Java Develoment Kit
#

########################################################################

#
# ファイル／ディレクトリ構造
#   ${BASE_DIR}
#       +- java : ${JAVA_DIR}
#       |    +-- 17 : ${JAVA_MAJOR}
#       +- clinit-20-java.bat
#

JAVA_DIR = java

CLINIT_JAVA_SRC = clinit-20-java.src
CLINIT_JAVA_BAT = clinit-20-java.bat

########################################################################

JAVA_MAJOR = 17
JAVA_MINOR = ${JAVA17_MINOR}
JAVA_PATCH = ${JAVA17_PATCH}
JAVA_VERSION = ${JAVA17_VERSION}
JAVA_ZIP = ${JAVA17_ZIP}

JAVA17_MINOR = 0.10
JAVA17_PATCH = 7
JAVA17_VERSION = -17.${JAVA17_MINOR}+${JAVA17_PATCH}
JAVA17_ZIP = ${DIST_DIR}/OpenJDK17U-jdk_x64_windows_hotspot_17.${JAVA17_MINOR}_${JAVA17_PATCH}.zip

########################################################################

java: ${BASE_DIR}/${CLINIT_JAVA_BAT}

${BASE_DIR}/${JAVA_DIR}/${JAVA_MAJOR}/bin/javac.exe:
	${MAKE} ${MAKE_FLAGS} ${BASE_DIR} 
	${7Z} x ${JAVA_ZIP} -o${BASE_DIR}/${JAVA_DIR}
	${MV} ${BASE_DIR}/${JAVA_DIR}/jdk${JAVA_VERSION} ${BASE_DIR}/${JAVA_DIR}/${JAVA_MAJOR}

${BASE_DIR}/${CLINIT_JAVA_BAT}: ${CLINIT_JAVA_SRC}
	${MAKE} ${MAKE_FLAGS} cl
	${MAKE} ${MAKE_FLAGS} ${BASE_DIR}/${JAVA_DIR}/${JAVA_MAJOR}/bin/javac.exe 
	${RM} ${BASE_DIR}/${CLINIT_JAVA_BAT}
	${CAT} ${CLINIT_JAVA_SRC} \
	    | ${SED} -e 's|__JAVA_DIR__|${JAVA_DIR}${WIN_PATH_SEP}${JAVA_MAJOR}|g' \
	    > ${BASE_DIR}/${CLINIT_JAVA_BAT}

########################################################################

clean::
	${RM} ${BASE_DIR}/${CLINIT_JAVA_BAT}

clean::
	${RM} -R ${BASE_DIR}/${JAVA_DIR}

#
# ProGENv-java: Portable Programming Environment - Java Develoment Kit
#

########################################################################

#
# ファイル／ディレクトリ構造
#   ${BASE_DIR}
#       +- java : ${JAVA_DIR}
#       |    +-- 21 : ${JAVA_MAJOR}
#       +- clinit-20-java.bat
#

JAVA_DIR = java

CLINIT_JAVA_SRC = clinit-20-java.src
CLINIT_JAVA_BAT = clinit-20-java.bat

########################################################################

JAVA_MAJOR = 25
JAVA_MINOR = ${JAVA25_MINOR}
JAVA_PATCH = ${JAVA25_PATCH}
JAVA_VERSION = ${JAVA25_VERSION}
JAVA_ZIP = ${JAVA25_ZIP}

JAVA25_MINOR = 0.3
JAVA25_PATCH = 9
JAVA25_VERSION = -25.${JAVA25_MINOR}+${JAVA25_PATCH}
JAVA25_ZIP = ${DIST_DIR}/OpenJDK25U-jdk_x64_windows_hotspot_25.${JAVA25_MINOR}_${JAVA25_PATCH}.zip
# Download from https://adoptium.net/temurin/releases/?os=windows&arch=x64&package=jdk

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

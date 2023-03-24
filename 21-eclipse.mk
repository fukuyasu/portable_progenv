#
# ProGENv-eclipse: Portable Programming Environment - Eclipse
#

########################################################################

#
# ファイル／ディレクトリ構造
#   ${BASE_DIR}
#       +- java : ${JAVA_DIR}
#       |    +-- 17 : ${JAVA_MAJOR}
#       +- eclipse : ${ECLIPSE_DIR}
#       +- workspace : ${ECLIPSE_WORKSPACE}
#

ECLIPSE_DIR = eclipse
ECLIPSE_WORKSPACE = workspace

########################################################################

ECLIPSE_VERSION = 2023-03-R
ECLIPSE_ZIP = ${DIST_DIR}/eclipse-java-${ECLIPSE_VERSION}-win32-x86_64.zip
ECLIPSE_CONFIG_SCRIPT = eclipseconf.sh

########################################################################

eclipse: ${BASE_DIR}/${ECLIPSE_DIR}

ECLIPSE_INI = ${BASE_DIR}/${ECLIPSE_DIR}/eclipse.ini

${BASE_DIR}/${ECLIPSE_DIR}:
	${MAKE} ${MAKE_FLAGS} java
	${7Z} x ${ECLIPSE_ZIP} -o${BASE_DIR}
	# Eclipse起動用のJREを ${JAVA_DIR}/${JAVA_MAJOR} にインストールしたバイナリに設定
	${SED} -i 's|\(-product\)|-vm\n../${JAVA_DIR}/${JAVA_MAJOR}/bin/javaw.exe\n\1|' ${ECLIPSE_INI}
	# ワークスペースを ../workspace に設定
	${MAKE} ${MAKE_FLAGS} ${BASE_DIR}/${ECLIPSE_WORKSPACE}
	${SED} -i 's|\(-Dosgi.instance.area.default.*\)/eclipse-workspace|\1/${ECLIPSE_WORKSPACE}|' ${ECLIPSE_INI}
	echo -e '-Duser.home=../' >> ${ECLIPSE_INI}
	# Eclipseの設定ファイルを書き換え
	${SHELL} ${ECLIPSE_CONFIG_SCRIPT} ${BASE_DIR}/${ECLIPSE_DIR} ${BASE_DIR}/${ECLIPSE_WORKSPACE}

${BASE_DIR}/${ECLIPSE_WORKSPACE}:
	${MKDIR} ${BASE_DIR}/${ECLIPSE_WORKSPACE}

########################################################################

clean::
	${RM} -R ${BASE_DIR}/${ECLIPSE_DIR}
	${RM} -R ${BASE_DIR}/${ECLIPSE_WORKSPACE}

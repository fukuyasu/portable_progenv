#
# ProGENv-pleiades: Portable Programming Environment - Pleiades
#

########################################################################

#
# ファイル／ディレクトリ構造
#   ${BASE_DIR}
#       +- java : ${JAVA_DIR}
#       |    +-- 17 : ${JAVA_MAJOR}
#       +- eclipse : ${ECLIPSE_DIR}
#       +- workspace : ${ECLIPSE_WORKSPACE}
#   ${TMP_DIR}
#       +- pleiades : ${PLEIADES_DIR}
#

PLEIADES_DIR = pleiades

########################################################################

PLEIADES_VERSION = 2022.03.26
PLEIADES_ZIP = ${DIST_DIR}/pleiades-win-${PLEIADES_VERSION}.zip

########################################################################

pleiades: ${BASE_DIR}/${ECLIPSE_DIR}/plugins/jp.sourceforge.mergedoc.pleiades/pleiades.jar

${BASE_DIR}/${ECLIPSE_DIR}/plugins/jp.sourceforge.mergedoc.pleiades/pleiades.jar:
	${MAKE} ${MAKE_FLAGS} eclipse
	${MAKE} ${MAKE_FLAGS} ${TMP_DIR}/${PLEIADES_DIR}
	${FIND} ${TMP_DIR}/${PLEIADES_DIR} -mindepth 1 -maxdepth 1 ! -name "setup*" \
		-exec ${CP} -R {} ${BASE_DIR}/${ECLIPSE_DIR}/ \;
	# pleiades を有効化
	echo '-Xverify:none' >> ${ECLIPSE_INI}
	echo '-javaagent:plugins/jp.sourceforge.mergedoc.pleiades/pleiades.jar' >> ${ECLIPSE_INI}

${TMP_DIR}/${PLEIADES_DIR}:
	${MAKE} ${MAKE_FLAGS} ${TMP_DIR}
	${7Z} x ${PLEIADES_ZIP} -o${TMP_DIR}/${PLEIADES_DIR}

########################################################################

clean::
	${RM} -R ${TMP_DIR}/${PLEIADES_DIR}

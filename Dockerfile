FROM oraclelinux

RUN groupadd dba && useradd -m -G dba oracle && mkdir /u01 && chown oracle:dba /u01
RUN yum install -y yum install oracle-rdbms-server-11gR2-preinstall glibc-static wget unzip && yum clean all

#ADD linux.x64_11gR2_database_1of2.zip /
#ADD linux.x64_11gR2_database_2of2.zip /

ADD install /install
RUN chmod +x  && /install/oracle_install.sh

ENV DBCA_TOTAL_MEMORY 4096
ENV WEB_CONSOLE true

ENV ORACLE_SID=EE
ENV ORACLE_HOME=/u01/app/oracle/product/11.2.0/EE
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/u01/app/oracle/product/11.2.0/EE/bin

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /install/oracle_install.sh

EXPOSE 1521
EXPOSE 8080
VOLUME ["/docker-entrypoint-initdb.d", "/u01/app/oracle"]

ENTRYPOINT ["/entrypoint.sh"]
CMD [""]

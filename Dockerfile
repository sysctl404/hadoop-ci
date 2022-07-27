FROM hadoop-build-env AS build

RUN git clone -b branch-3.1.3 --single-branch https://github.com/apache/hadoop.git hadoop-3.1.3 && \
cd hadoop-3.1.3 && \
mvn package -Pdist -DskipTests -Dtar -Dmaven.javadoc.skip=true

FROM scratch AS export
COPY --from=build /root/hadoop-3.1.3/hadoop-dist/target/hadoop-3.1.3.tar.gz /

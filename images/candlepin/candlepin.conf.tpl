candlepin.consumer_system_name_pattern=.+

candlepin.environment_content_filtering=true
candlepin.auth.basic.enable=false
candlepin.auth.trusted.enable=false

candlepin.db.database_manage_on_startup=Manage

candlepin.auth.oauth.enable=true
candlepin.auth.oauth.consumer.katello.secret=${CANDLEPIN_OAUTH_SECRET}

module.config.adapter_module=org.candlepin.katello.KatelloModule

candlepin.ca_key=/etc/candlepin/certs/candlepin-ca.key
candlepin.ca_cert=/etc/candlepin/certs/candlepin-ca.crt

candlepin.async.jobs.ExpiredPoolsCleanupJob.schedule=0 0 0 * * ?

jpa.config.hibernate.dialect=org.hibernate.dialect.PostgreSQLDialect
jpa.config.hibernate.hbm2ddl.auto=validate
jpa.config.hibernate.connection.username=${CANDLEPIN_DB_USERNAME}
jpa.config.hibernate.connection.password=${CANDLEPIN_DB_PASSWORD}
jpa.config.hibernate.connection.driver_class=org.postgresql.Driver
jpa.config.hibernate.connection.url=${CANDLEPIN_DB_URL}


org.quartz.jobStore.misfireThreshold=60000
org.quartz.jobStore.useProperties=false
org.quartz.jobStore.dataSource=myDS
org.quartz.jobStore.tablePrefix=QRTZ_
org.quartz.jobStore.class=org.quartz.impl.jdbcjobstore.JobStoreTX
org.quartz.jobStore.driverDelegateClass=org.quartz.impl.jdbcjobstore.PostgreSQLDelegate

org.quartz.dataSource.myDS.driver=org.postgresql.Driver
org.quartz.dataSource.myDS.user=${CANDLEPIN_DB_USERNAME}
org.quartz.dataSource.myDS.password=${CANDLEPIN_DB_PASSWORD}
org.quartz.dataSource.myDS.maxConnections=5
org.quartz.dataSource.myDS.URL=${CANDLEPIN_DB_URL}

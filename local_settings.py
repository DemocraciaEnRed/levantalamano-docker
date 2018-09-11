SECRET_KEY
DEBUG = True
HAYSTACK_CONNECTIONS = {
        'default': {
            'ENGINE': 'haystack.backends.elasticsearch2_backend.Elasticsearch2SearchEngine',
            'URL': 'http://elastic:9200',
            'INDEX_NAME': 'levantalamano',
        },
}
LANGUAGE_CODE = 'es-ar'
TIME_ZONE = 'America/Argentina/Buenos_Aires'
CACHES = {
        'default': {
            'BACKEND': 'django.core.cache.backends.memcached.MemcachedCache',
            'LOCATION': 'memcache:11211',
        }
}
ROOT_URLCONF = 'votita.stand_alone_urls'
CONSTANCE_BACKEND = 'constance.backends.redisd.RedisBackend'
CONSTANCE_REDIS_CONNECTION = {
        'host': 'redis',
        'port': 6379,
        'db': 0
}

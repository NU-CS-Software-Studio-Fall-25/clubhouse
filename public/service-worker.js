const CACHE_VERSION = 'v1';
const CACHE_NAME = `clubhouse-${CACHE_VERSION}`;

// Assets we want to cache on install
const PRECACHE_ASSETS = [
  '/',
  '/manifest.webmanifest',
  '/icon.png',
  '/icon.svg',
  '/icon.ico'
];

// Install event - precache critical assets
self.addEventListener('install', event => {
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then(cache => cache.addAll(PRECACHE_ASSETS))
      .then(() => self.skipWaiting())
  );
});

// Activate event - clean up old caches
self.addEventListener('activate', event => {
  event.waitUntil(
    caches.keys().then(cacheNames => {
      return Promise.all(
        cacheNames
          .filter(cacheName => cacheName.startsWith('clubhouse-'))
          .filter(cacheName => cacheName !== CACHE_NAME)
          .map(cacheName => caches.delete(cacheName))
      );
    }).then(() => self.clients.claim())
  );
});

// Fetch event - network first for dynamic content, cache first for assets
self.addEventListener('fetch', event => {
  // Only handle GET requests
  if (event.request.method !== 'GET') return;

  // Skip some types of requests
  if (
    event.request.url.includes('/auth/') || // Skip auth-related requests
    event.request.url.includes('/cable') || // Skip ActionCable
    event.request.url.includes('/admin/')   // Skip admin routes if you have any
  ) {
    return;
  }

  // For HTML requests - network first with cache fallback
  if (event.request.headers.get('accept')?.includes('text/html')) {
    event.respondWith(
      fetch(event.request)
        .then(response => {
          const clone = response.clone();
          caches.open(CACHE_NAME)
            .then(cache => cache.put(event.request, clone));
          return response;
        })
        .catch(() => {
          return caches.match(event.request);
        })
    );
    return;
  }

  // For static assets - cache first with network fallback
  if (
    event.request.url.match(/\.(js|css|png|jpg|jpeg|gif|svg|ico)$/) ||
    event.request.url.includes('bootstrap')
  ) {
    event.respondWith(
      caches.match(event.request)
        .then(cachedResponse => {
          if (cachedResponse) {
            return cachedResponse;
          }
          return fetch(event.request)
            .then(response => {
              const clone = response.clone();
              caches.open(CACHE_NAME)
                .then(cache => cache.put(event.request, clone));
              return response;
            });
        })
    );
    return;
  }

  // For everything else - network first with cache fallback
  event.respondWith(
    fetch(event.request)
      .then(response => {
        const clone = response.clone();
        caches.open(CACHE_NAME)
          .then(cache => cache.put(event.request, clone));
        return response;
      })
      .catch(() => {
        return caches.match(event.request);
      })
  );
});
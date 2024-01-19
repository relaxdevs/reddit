

Map cache = {};
Map cacheStamp = {};

Map? getCache(String query, int interval) {
  int stamp = DateTime.now().millisecondsSinceEpoch;

  return (cache[query] != null && ((stamp - cacheStamp[query]) < interval))
    ? cache[query]
    : null;
}

void addCache(String query, Map item) {
  cacheStamp[query] = DateTime.now().millisecondsSinceEpoch;
  cache[query] = item;
}
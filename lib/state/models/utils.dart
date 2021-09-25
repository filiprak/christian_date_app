
String normalizeUrl(String url) {
  return url.startsWith('https:') ? url : 'https:' + url;
}

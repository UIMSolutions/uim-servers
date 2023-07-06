module source.uim.servers.mixins.local;

template ImportLocal(string name) {
  const char[] ImportLocal = `
//public import servers.`~name~`.apis;
public import servers.`~name~`.components;
//public import servers.`~name~`.layouts;
//public import servers.`~name~`.pages;
  `;
}
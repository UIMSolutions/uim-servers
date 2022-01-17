module uim.servers;

@safe:
public import std.algorithm;
public import std.digest.sha;
public import std.stdio;
public import std.string;
public import std.uuid;

public import vibe.d;

public import uim.core;
public import uim.oop;
public import uim.javascript;
public import uim.html;
// // public import uim.web;
// public import uim.entities;
public import uim.jsonbase;
public import uim.entities;
public import uim.entitybase;
public import uim.apps;

public import uim.servers.controller;
public import uim.servers.server;
public import uim.servers.securities;
public import uim.servers.apis;
public import uim.servers.data.helpers;
public import uim.servers.data.messages;
public import uim.servers.helpers;
public import uim.servers.mixins;
public import uim.servers.sessions;


bool notValidSession(string sessionToken, STRINGAA parameters = null) { return !isValidSession(sessionToken, parameters); }

bool isValidSession(string sessionToken, STRINGAA parameters = null) {
  if (sessionToken == "demo") return true;
  return false;
}

DSRVSession[string] srvSessions;


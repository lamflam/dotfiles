/**
 * Uses some heuristics to determine if this is a Gmail "App" Shortcut.
 *
 * You can create shortcuts from the Chrome menu by going to
 *   "Menu > More Tools > Create Shortcut"
 *
 * The heuristics we use are:
 * - There can only be one tab. (Shortcuts are single-tab things.)
 * - The active tab URL has to start with "https://mail.google.com/mail"
 * - And the window doesn't have a name.
 *   (This prevents us from accidentally assigning this to a Chrome window.)
 *
 * TODO: I feel like there might be some better heuristic to check.
 *       There's both an Application("Google Chrome") and an Application("Gmail"),
 *       but the Gmail instance doesn't have access to the same Script dictionary
 *       as Google Chrome. I might be able to get at the Google Chrome instance
 *       from the Gmail instance, though, somehow.
 *
 * @param {Window} window - The window object to check.
 */
function isGmailAppShortcut(window) {
  if (window.tabs().length > 1) return false;
  const tab = window.activeTab();
  return (
    window.name() === "" && tab.url().startsWith("https://mail.google.com/mail")
  );
}

/**
 * Find the Inbox unread count and set the app badge.
 *
 * This script:
 * 1. finds the [data-tooltip=Inbox] node,
 * 2. walks all the Node.TEXT_NODE nodes that are in the children,
 * 3. finds the one that is just a number
 * 4. and sets that to the app's badge icon.
 */
let setAppBadge = function () {
  let inbox = document.querySelector("[data-tooltip=Inbox]");
  let walk = document.createTreeWalker(inbox, NodeFilter.SHOW_TEXT);
  let node;
  let badgeSet = false;
  do {
    node = walk.nextNode();
    if (node?.textContent.match(/^\d+$/)) {
      navigator.setAppBadge(node.textContent);
      badgeSet = true;
      break;
    }
  } while (node != null);
  if (!badgeSet) {
    navigator.setAppBadge(0);
  }
}.toString();

// Find the Gmail shortcut window
let allWindows = Application("com.google.Chrome").windows();
let gmail = allWindows.find(isGmailAppShortcut);

if (gmail) {
  gmail.activeTab().execute({ javascript: `(${setAppBadge})()` });
}

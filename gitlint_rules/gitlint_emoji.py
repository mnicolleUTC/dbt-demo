"""
Gitlint extra rule to validate that the message title is of the form
"<gitmoji>(<scope>) <subject>"
"""

import re
import sys

from gitlint.rules import CommitMessageTitle
from gitlint.rules import LineRule
from gitlint.rules import RuleViolation

sys.path.append("./venv/lib/python3.10/site-packages/")

import requests  # noqa: E402


class GitmojiTitle(LineRule):
    """
    This rule will enforce that each commit title is of the form
    "<gitmoji>(<scope>) <subject>"
    where gitmoji is an emoji from the list defined in
    https://gitmoji.carloscuesta.me and subject should be all lowercase
    """

    id = "UC1"
    name = "title-should-have-gitmoji-and-scope"
    target = CommitMessageTitle

    def validate(self, title, _commit):
        """
        Download the list possible gitmojis from the project's github
        repository and check that title contains one of them.
        """
        gitmojis = requests.get(
            "https://raw.githubusercontent.com/carloscuesta/gitmoji/"
            "master/packages/gitmojis/src/gitmojis.json"
        ).json()["gitmojis"]
        emojis = [item["emoji"] for item in gitmojis]
        pattern = r"^({:s})\s\(.*\)\s[a-z].*$".format("|".join(emojis))
        if not re.search(pattern, title):
            violation_msg = (
                'Title does not match regex "<gitmoji>(<scope>) <subject>"'
            )
            return [RuleViolation(self.id, violation_msg, title)]

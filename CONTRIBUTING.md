Checklist (abreviated)
======================

  * Commits:

    - Commits should be logically grouped. Do not have multiple unrelated changes in a single commit.

    - Avoid unnesscessary whitespace additions. Use "git diff --check" before committing.
    - Avoid checking in commented code or nonrelevant files.

    - The first line of the commit message should be less than 50 characters and is the title of the change. Additional details may be included on additional lines.

    - Associate the Issue ID on the first line of the commit message in the form of "(#XXX) Rest of Message"

    - The body of the commit message should be meaningful and provide enough detail as to why the change was needed.

  * Submission:

    * Preferred Method:

      - Fork the repository on GitHub.

      - Push your changes to a topic branch in your fork of the repository. (the format ticket/1234-short_description_of change is usually preferred.

      - Submit a pull request to the repository.

      - Contributions will only be accepted if spec / acceptance tests are included and passing. If you require assistance please submit the request and ask for advice.

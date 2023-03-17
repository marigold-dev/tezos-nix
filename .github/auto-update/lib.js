const https = require("https");
const { URL } = require("url");

const { exec } = require("child_process");

function http_request(uri) {
  return new Promise((resolve, reject) => {
    const url = new URL(uri);

    return https
      .get(
        {
          port: 443,
          path: url.pathname + url.search,
          protocol: url.protocol,
          hostname: url.hostname,
          method: "GET",
          headers: {
            "User-Agent": "GithubActions",
            Accept: "application/json",
          },
          url,
        },
        (res) => {
          const response_data = [];
          res.on("data", (data) => {
            response_data.push(data);
          });

          res.on("end", () => {
            const response = Buffer.concat(response_data);
            const response_string = response.toString();

            try {
              return resolve(JSON.parse(response_string));
            } catch (e) {
              return reject(e);
            }
          });
        }
      )
      .on("error", reject);
  });
}

function get_commits(sha1, sha2) {
  return http_request(
    `https://gitlab.com/api/v4/projects/3836952/repository/compare?from=${sha1}&to=${sha2}`
  )
    .then((res) => {
      return {
        web_url: res.web_url,
        commits: res.commits.map((commit) => ({
          title: commit.title,
          web_url: commit.web_url,
        })),
      };
    })
    .catch((e) => {
      console.error(e);
      return {
        error: "Error occurred, there could be relevant commits missing",
      };
    });
}

function find_shas() {
  return new Promise((resolve, reject) => {
    exec("git diff ./flake.lock", (error, output) => {
      if (error == null) {
        reject(error);
        return;
      } else {
        let prev_sha_regex = /tezos_trunk.*-        "rev": "([A-Za-z0-9]+)"/ms;
        let next_sha_regex = /tezos_trunk.*\+        "rev": "([A-Za-z0-9]+)"/ms;
      
        const prev_match = output.match(prev_sha_regex);
        const next_match = output.match(next_sha_regex);

        // Only write the file if the commit hash has changed
        // Otherwise just cancel the workflow. We don't need to do anything
        if (prev_rev.startsWith(next_sha)) {
          reject(new Error("Shas were the same"));
          return;
        }

        resolve({ prev_sha: prev_match[1], next_sha: next_match[1] });
        return;
      }      
    });
  });
}

function escapeForGHActions(s) {
  // Escape `"` and `$` characters in a string to work around the following
  // `` ` `` and `'` seems to be problematic as well
  // issue:
  // https://github.com/repo-sync/pull-request/issues/27
  return s
    .replace(/\$/g, "\\$")
    .replace(/"/g, '\\"')
    .replace(/`/g, "\\`")
    .replace(/\'/g, "\\'");
}

module.exports = {
  find_shas,
  get_commits,
  escapeForGHActions,
};

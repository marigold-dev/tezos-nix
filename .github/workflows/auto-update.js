module.exports = async ({ github, context, core, require }) => {
  const lib = require("./.github/auto-update/lib.js");
  const {
    update_trunk,
    get_commits,
    escapeForGHActions,
  } = lib(require);

  return update_trunk()
    .then(shas => get_commits(shas.prev_sha, shas.next_sha))
    .then(diff => {
      const url = diff.web_url;

      const commit_texts = diff.commits.map(({ title, web_url }) => {
        const message = escapeForGHActions(title);
        return `* <a href="${web_url}"><pre>${message}</pre></a>`;
      });

      const post_text = `
#### New commits on tezos/tezos Trunk
${commit_texts.join("\n")}

#### Diff URL: ${url}
`;

    return post_text;
  })
  .catch((error) => {
    console.error(error);
    core.notice(error.message);
    github.rest.actions.cancelWorkflowRun({
      owner: context.repo.owner,
      repo: context.repo.repo,
      run_id: context.runId,
    });

    return "";
  });
};

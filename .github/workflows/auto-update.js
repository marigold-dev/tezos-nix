module.exports = async ({ github, context, core, require }) => {
  const {
    find_shas,
    get_commits,
    escapeForGHActions,
  } = require("./.github/auto-update/lib.js");
  try {
    const shas = find_shas();

    // Only write the file if the commit hash has changed
    // Otherwise just cancel the workflow. We don't need to do anything
    if (shas.prev_rev.startsWith(shas.next_sha)) {
      throw new Error("Shas were the same");
    }

    const diff = await get_commits(shas.prev_sha, shas.next_sha);

    const url = diff.web_url;

    const commit_texts = diff.commits.map(({ title, web_url }) => {
      const message = escapeForGHActions(title);
      return `* <a href="${web_url}"><pre>${message}</pre></a>`;
    });

    const post_text = `
  #### New commits on tezos/tezos Trunk
  ${commit_texts.join("\n")}
  
  #### Diff URL: ${url}
  
  ${
    error != null
      ? `#### Error
  
  ${error}
  
  `
      : ""
  }
        `;

    return post_text;
  } catch (error) {
    (error) => {
      console.error(error);
      core.notice(error.message);
      github.rest.actions.cancelWorkflowRun({
        owner: context.repo.owner,
        repo: context.repo.repo,
        run_id: context.runId,
      });

      return "";
    };
  }
};

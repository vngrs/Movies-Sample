import Danger
let danger = Danger()

let editedFiles = danger.git.modifiedFiles + danger.git.createdFiles
message("These files have changed: \(editedFiles.joined(separator: ", "))")

var bigPRThreshold = 600
if danger.github.pullRequest.additions! + danger.github.pullRequest.deletions! > bigPRThreshold {
  warn("Pull Request size seems relatively large. If this Pull Request contains multiple changes,please split each into separate PR will helps faster, easier review.")
}

// Pull request title validation
let prTitle = danger.github.pullRequest.title
if prTitle.contains("WIP") {
    warn("PR is classed as _Work in Progress_.")
}

SwiftLint.lint()

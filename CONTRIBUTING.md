# 🤝 Contributing to Autonomous AI Agents

Thank you for your interest in contributing to this collection of autonomous AI agents! This guide will help you get started.

---

## 🎯 How to Contribute

### 🐛 Reporting Issues

**Bug Reports**
- Use the [Bug Report Template](.github/ISSUE_TEMPLATE/bug_report.md)
- Include detailed reproduction steps
- Specify which agent(s) are affected
- Provide expected vs actual behavior

**Feature Requests**
- Use the [Feature Request Template](.github/ISSUE_TEMPLATE/feature_request.md)
- Describe the use case clearly
- Explain why it would benefit the community
- Consider if it fits the autonomous agent philosophy

### 🤖 Creating New Agents

We welcome new agent specializations! Before creating one:

1. **Check existing agents** - Ensure your specialty isn't already covered
2. **Review agent standards** - Follow our established patterns
3. **Consider scope** - Keep agents focused and specific
4. **Test thoroughly** - Validate in real scenarios

#### Agent Creation Standards

**File Naming**
```
AGENT_NAME.md  # Use uppercase, descriptive names
Examples: SENTINEL.md, BOLT.md, ATLAS.md
```

**Agent Structure Template**
```markdown
You are "[Agent Name]" 🎯 - [brief specialty description]

Your mission is to [specific goal and scope]. And ensure the build passes without build or lint errors or warnings.

## Boundaries

✅ **Always do:**
- [Positive actions agent should take]
- [Required behaviors and patterns]

⚠️ **Ask first:**
- [Areas requiring caution or approval]
- [Changes that need discussion]

🚫 **Never do:**
- [Forbidden actions and anti-patterns]
- [Things to avoid at all costs]

## Daily Process

1. 🔍 [Phase 1 - Analysis/Discovery]
2. 🎯 [Phase 2 - Prioritization]  
3. 🔧 [Phase 3 - Implementation]
4. ✅ [Phase 4 - Verification]
5. 🎁 [Phase 5 - Documentation]

## Priority Areas
[List of specific focus areas with priorities]

## Common Patterns
[Code examples and best practices]

## Boundaries (Expanded)
[Detailed rules and constraints]

Remember: [Closing philosophy statement]
```

**Required Sections**
- Agent name and emoji
- Clear mission statement
- Boundaries (Always/Ask/Never)
- Daily process (5 phases)
- Priority areas
- Common patterns
- Philosophy statement

### 📝 Improving Documentation

**Documentation Types**
- **Agent improvements** - Enhance existing agent prompts
- **Guide creation** - Add new how-to guides
- **Examples** - Provide real-world usage examples
- **Translations** - Help translate to other languages

**Documentation Standards**
- Use clear, concise language
- Include code examples
- Add visual elements when helpful
- Follow markdown best practices
- Test all instructions

### 🔧 Fixing Issues

**Code Style**
- Follow existing patterns in the repository
- Use consistent formatting
- Add helpful comments when needed
- Keep changes focused and minimal

**Testing Your Changes**
- Test agent prompts in real scenarios
- Verify build/lint commands work
- Check for typos and formatting
- Ensure all links work

---

## 🚀 Getting Started

### 1. Fork the Repository

```bash
# Fork the repository on GitHub
# Clone your fork locally
git clone https://github.com/YOUR_USERNAME/autonomous-ai-agents.git
cd autonomous-ai-agents

# Add the original repository as upstream
git remote add upstream https://github.com/ORIGINAL_OWNER/autonomous-ai-agents.git
```

### 2. Create a Branch

```bash
# Create a new branch for your contribution
git checkout -b feature/your-feature-name

# Or for bug fixes
git checkout -b fix/issue-description
```

### 3. Make Your Changes

- Follow the agent creation standards
- Test your changes thoroughly
- Update documentation if needed
- Keep commits focused and atomic

### 4. Commit Your Changes

```bash
# Use clear, descriptive commit messages
git add .
git commit -m "feat: add new agent for database optimization"
```

**Commit Message Format**
```
type(scope): description

feat: new feature
fix: bug fix  
docs: documentation
style: formatting
refactor: code refactoring
test: testing
chore: maintenance
```

### 5. Submit a Pull Request

```bash
# Push to your fork
git push origin feature/your-feature-name

# Create a pull request on GitHub
# Use the PR template and fill out all sections
```

---

## 📋 Pull Request Guidelines

### PR Requirements

- [ ] **Clear description** - Explain what you changed and why
- [ ] **Tests passed** - Verify your changes work as expected
- [ ] **Documentation updated** - Update relevant docs
- [ ] **No breaking changes** - Maintain backward compatibility
- [ ] **Follows standards** - Adhere to agent creation guidelines

### PR Template

```markdown
## Description
[Brief description of changes]

## Type of Change
- [ ] Bug fix
- [ ] New feature  
- [ ] Documentation update
- [ ] Agent improvement
- [ ] Other (please describe)

## Testing
- [ ] Tested with real codebase
- [ ] Verified build/lint commands
- [ ] Checked all links and formatting

## Checklist
- [ ] Code follows project standards
- [ ] Self-review completed
- [ ] Documentation updated
- [ ] Ready for review
```

### Review Process

1. **Automated checks** - CI/CD pipeline runs
2. **Community review** - Maintainers and contributors review
3. **Feedback integration** - Address any requested changes
4. **Approval and merge** - Once approved, changes are merged

---

## 🎯 Agent Development Guidelines

### Design Principles

**1. Single Responsibility**
- Each agent should have one clear specialty
- Avoid overlapping responsibilities with existing agents
- Keep scope focused and manageable

**2. Autonomous Operation**
- Agents should work independently
- Minimal human intervention required
- Clear decision-making criteria

**3. Measurable Impact**
- Focus on changes that can be measured
- Provide clear before/after comparisons
- Document expected improvements

**4. Safe Operations**
- Never break existing functionality
- Always verify builds pass
- Include rollback considerations

### Technical Standards

**Prompt Engineering**
- Use clear, unambiguous language
- Include specific examples and patterns
- Provide context and constraints
- Test with multiple AI platforms

**Code Examples**
```markdown
# Good example
```typescript
// ✅ GOOD: Clear pattern with explanation
const optimized = useMemo(() => {
  return expensiveCalculation(data);
}, [data]);
```

# Bad example  
```typescript
// ❌ BAD: Vague, no context
const memo = useMemo(() => calc(data), [data]);
```
```

**Error Handling**
- Include verification steps
- Provide fallback options
- Document edge cases
- Test failure scenarios

---

## 🏆 Recognition

### Contributor Recognition

- **Contributors list** - All contributors are listed in README
- **Agent attribution** - New agents include contributor credit
- **Release notes** - Major contributions mentioned in releases
- **Community highlights** - Outstanding contributions featured

### Success Metrics

- **Agent adoption** - How many teams use your agent
- **Issue resolution** - Problems your agent solves
- **Community feedback** - Reviews and testimonials
- **Improvement impact** - Measurable codebase enhancements

---

## 🤝 Community Guidelines

### Code of Conduct

**Be Respectful**
- Treat all contributors with respect
- Welcome newcomers and help them learn
- Appreciate different perspectives and approaches

**Be Constructive**
- Provide helpful, specific feedback
- Focus on what can be improved
- Suggest solutions, not just problems

**Be Inclusive**
- Use inclusive language
- Consider diverse use cases
- Make documentation accessible

### Communication Channels

- **GitHub Issues** - Bug reports and feature requests
- **GitHub Discussions** - General questions and ideas
- **Pull Requests** - Code contributions and reviews
- **Twitter/X** - Community updates and announcements

---

## 📚 Resources

### Helpful Links

- [Agent Architecture Guide](docs/AGENT_ARCHITECTURE.md)
- [Integration Guide](docs/INTEGRATION_GUIDE.md)  
- [Best Practices](docs/BEST_PRACTICES.md)
- [FAQ](docs/FAQ.md)

### External Resources

- [Jules.ai Documentation](https://jules.ai/docs)
- [AI Prompt Engineering Best Practices](https://www.promptingguide.ai/)
- [Open Source Contribution Guide](https://opensource.guide/)

---

## 🎉 Thank You!

Your contributions help make autonomous codebase optimization accessible to everyone. Whether you're fixing a typo, creating a new agent, or improving documentation, your efforts are appreciated and valued.

**Together, we're building the future of autonomous development! 🚀**

---

<div align="center">

[📖 View Documentation](docs/) • [🐛 Report Issues](../../issues) • [💬 Join Discussions](../../discussions)

Made with ❤️ by the autonomous agents community

</div>

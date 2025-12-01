# The 5 Whys Technique

This reference provides detailed guidance on using the 5 Whys technique for root cause analysis during vision discovery. The technique helps uncover the true problem behind surface-level symptoms, ensuring the product vision addresses fundamental user needs rather than superficial issues.

---

## Overview

The 5 Whys is a simple but powerful iterative questioning technique used to explore the cause-and-effect relationships underlying a problem. By repeatedly asking "Why?" (typically five times, though sometimes more or fewer), you peel back layers of symptoms to reach the root cause.

**Origin:** Developed by Sakichi Toyoda and used within the Toyota Production System for continuous improvement.

**In Vision Discovery:** Use 5 Whys to transform vague problem statements into clear, actionable insights that form the foundation of a compelling product vision.

---

## When to Use

The 5 Whys technique is most effective when:

| Scenario | Why 5 Whys Helps |
|----------|------------------|
| User describes a symptom, not a problem | Reveals the underlying issue they actually need solved |
| Problem statement is too vague | Adds specificity and actionable context |
| Multiple stakeholders disagree on the problem | Finds common ground at the root cause level |
| Proposed solution seems to miss the point | Redirects focus from solution-first to problem-first thinking |
| User keeps changing requirements | Identifies unstable requirements rooted in unclear problems |

### Signs You Need 5 Whys

- User says "We need a dashboard" without explaining what's wrong with current visibility
- Problem statement uses buzzwords: "We need to be more agile" or "We need better insights"
- User jumps straight to features: "We need an AI chatbot" without explaining the user pain
- Problem feels too broad: "Our process is inefficient"

---

## Process

### Step 1: Start with the Surface Problem

Document the initial problem statement exactly as the user describes it. Don't rephrase or interpret at this stage.

**Example Starting Point:**
> "Our marketing team spends too much time on reporting."

### Step 2: Ask "Why?" and Document the Answer

Ask why this is a problem. Listen carefully and document the response. Each answer becomes the subject of the next "Why?"

### Step 3: Repeat Until You Reach the Root Cause

Continue asking "Why?" until you've uncovered a root cause that:

- Is actionable (you can do something about it)
- Reveals a systemic issue (not just a one-time occurrence)
- Explains why the symptom exists (causal relationship is clear)

### Step 4: Validate the Root Cause

Confirm with stakeholders that addressing this root cause would resolve the original problem. If not, you may need to explore a different branch.

### Step 5: Incorporate into Vision

Use the root cause to inform the problem statement section of your vision document.

---

## Worked Examples

### Example 1: Marketing Analytics Platform

| Level | Question | Answer |
|-------|----------|--------|
| Surface | What's the problem? | "Our marketing team spends too much time on reporting." |
| Why #1 | Why do they spend too much time? | "They have to pull data from 5 different platforms manually." |
| Why #2 | Why do they pull data manually? | "Each platform has its own dashboard and they don't talk to each other." |
| Why #3 | Why don't they use an integration tool? | "We tried one, but it couldn't handle our custom attribution model." |
| Why #4 | Why is custom attribution important? | "Standard attribution doesn't show which campaigns actually drive revenue." |
| Why #5 | Why does that matter? | "Without accurate attribution, we can't justify budget or optimize spend." |

**Root Cause:** Marketing leadership cannot make data-driven budget decisions because existing tools don't support their attribution model.

**Vision Impact:** The product vision should emphasize _decision-enabling analytics with flexible attribution_, not just "faster reporting."

---

### Example 2: Internal Knowledge Base

| Level | Question | Answer |
|-------|----------|--------|
| Surface | What's the problem? | "Employees can't find information they need." |
| Why #1 | Why can't they find it? | "Our documentation is scattered across multiple tools." |
| Why #2 | Why is it scattered? | "Different teams use different tools (Confluence, Google Docs, Notion)." |
| Why #3 | Why do teams use different tools? | "There was never a company-wide standard, so teams chose their own." |
| Why #4 | Why wasn't a standard established? | "We grew fast and prioritized speed over consistency." |
| Why #5 | Why is this a problem now? | "New hires take 3 months to become productive because they can't find answers." |

**Root Cause:** Lack of a unified knowledge system causes extended new hire ramp-up time and reduced productivity.

**Vision Impact:** The product vision should focus on _reducing time-to-productivity for new hires_, not just "better documentation."

---

### Example 3: E-commerce Operations

| Level | Question | Answer |
|-------|----------|--------|
| Surface | What's the problem? | "Our customer support costs are too high." |
| Why #1 | Why are costs too high? | "We have too many support tickets." |
| Why #2 | Why so many tickets? | "60% are about order status and delivery questions." |
| Why #3 | Why are customers asking about status? | "They can't find this information on our site." |
| Why #4 | Why can't they find it? | "Order tracking is buried in the account section and updates are delayed." |
| Why #5 | Why are updates delayed? | "Our carrier integration only syncs once per day." |

**Root Cause:** Customers contact support because real-time order tracking isn't accessible or accurate.

**Vision Impact:** The product vision should prioritize _proactive, real-time order visibility_, which will reduce support costs as a secondary effect.

---

## Common Pitfalls

### Stopping Too Early

**Problem:** Accepting the first or second answer as the root cause.

| Too Early | Keep Going |
|-----------|------------|
| "We need faster reporting" | _Why?_ What decisions are delayed? |
| "Users are frustrated" | _Why?_ What specifically frustrates them? |
| "The process is manual" | _Why?_ What should be automated and why? |

**Fix:** If the answer could still have a "Why?" behind it, keep going.

---

### Asking Leading Questions

**Problem:** Embedding assumptions in your questions.

| Leading (Avoid) | Neutral (Use) |
|-----------------|---------------|
| "Why don't you use our analytics tool?" | "Why is this information hard to get?" |
| "Why is the manual process slow?" | "Why is this a problem?" |
| "Why haven't you automated this?" | "Why do you do this manually?" |

**Fix:** Ask open-ended "Why?" questions without suggesting an answer.

---

### Assigning Blame

**Problem:** 5 Whys degenerates into finding fault with people.

| Blame-Oriented | Cause-Oriented |
|----------------|----------------|
| "Why didn't the team document this?" | "Why doesn't documentation exist?" |
| "Why did they make that decision?" | "What factors led to that decision?" |

**Fix:** Focus on systems, processes, and conditions—not individuals.

---

### Single-Branch Thinking

**Problem:** Assuming there's only one causal chain when multiple factors contribute.

**Fix:** At each level, ask: "Is there another reason why?" Branch into multiple paths and explore each.

```text
Surface Problem: "Projects are always late"
  ├─ Why? "Requirements change mid-project"
  │    └─ Why? "Stakeholders aren't involved early enough"
  └─ Why? "Estimates are too optimistic"
       └─ Why? "We don't account for dependencies"
```

---

### Going Too Deep (Analysis Paralysis)

**Problem:** Asking "Why?" beyond actionable causes into philosophical territory.

| Actionable (Stop Here) | Too Deep (Avoid) |
|------------------------|------------------|
| "Our data isn't integrated" | "Why does data exist in silos across the industry?" |
| "Users don't know the feature exists" | "Why do humans not read documentation?" |

**Fix:** Stop when you reach a cause you can address with your product.

---

## Tips for Facilitating 5 Whys with Stakeholders

### Before the Session

1. **Set expectations:** Explain the technique and its purpose
2. **Create safety:** Emphasize this is about finding causes, not assigning blame
3. **Identify participants:** Include people close to the problem (not just managers)

### During the Session

1. **Start with observation, not opinion:** "What happens?" before "What's wrong?"
2. **Write answers on a shared surface:** Whiteboard, Miro, or shared doc
3. **Let silence happen:** Give people time to think before answering
4. **Validate understanding:** "So what you're saying is..." before moving to the next Why
5. **Explore branches:** When multiple causes emerge, note all of them

### After the Session

1. **Summarize the root cause(s):** Document the key findings
2. **Connect to vision:** Show how the root cause informs the problem statement
3. **Share and validate:** Confirm with stakeholders that the root cause resonates

---

## 5 Whys Output Template

Use this template to document your 5 Whys analysis:

```markdown
## 5 Whys Analysis

**Surface Problem:** [Initial problem statement from user]

| Level | Question | Answer |
|-------|----------|--------|
| Why #1 | Why is [surface problem]? | [Answer 1] |
| Why #2 | Why [Answer 1]? | [Answer 2] |
| Why #3 | Why [Answer 2]? | [Answer 3] |
| Why #4 | Why [Answer 3]? | [Answer 4] |
| Why #5 | Why [Answer 4]? | [Answer 5 / Root Cause] |

**Root Cause:** [Concise statement of the fundamental issue]

**Vision Impact:** [How this informs the problem statement and product direction]
```

---

## Quick Reference

| Aspect | Guidance |
|--------|----------|
| **When to use** | Vague problems, symptom-based requests, solution-first conversations |
| **How many Whys** | 5 is typical; use fewer if root cause is clear, more if needed |
| **Key principle** | Focus on systems and processes, not people |
| **Signs of root cause** | Actionable, systemic, explains the symptom |
| **Common mistakes** | Stopping too early, leading questions, assigning blame, single-branch thinking |
| **Session duration** | 15-30 minutes per problem statement |

---

## Related References

- **Vision Template** (`references/vision-template.md`) - Use 5 Whys findings to complete the Problem Statement section
- **Sample Vision** (`examples/sample-vision.md`) - See how root cause analysis shapes a complete vision document

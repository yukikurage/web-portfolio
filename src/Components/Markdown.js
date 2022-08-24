import { marked } from "marked";

export const parseMarkdown = (markdown) => marked.parse(markdown);

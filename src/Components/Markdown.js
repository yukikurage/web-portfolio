import { marked } from "marked";
import hljs from "highlight.js";

marked.setOptions({
  langPrefix: "",
  highlight: (code, lang) => {
    return hljs.highlightAuto(code, [lang]).value;
  },
});

export const parseMarkdown = (markdown) => () => marked.parse(markdown);

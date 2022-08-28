import { marked } from "marked";
import hljs from "highlight.js/libs/highlight";
import javascript from "highlight.js/lib/languages/javascript";
import css from "highlight.js/lib/languages/css";

hljs.registerLanguage("javascript", javascript);
hljs.registerLanguage("css", css);

marked.setOptions({
  langPrefix: "",
  highlight: (code, lang) => {
    return hljs.highlightAuto(code, [lang]).value;
  },
});

export const parseMarkdown = (markdown) => () => marked.parse(markdown);

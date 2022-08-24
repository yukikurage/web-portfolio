export const setInnerHTML = (element) => (html) => () => {
  element.innerHTML = html;
}

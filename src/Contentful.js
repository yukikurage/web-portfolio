import contentful from "contentful";

const client = contentful.createClient({
  space: "iitjhomwjrtq",
  accessToken: "zWwdowYObU_WAXDZwVsrndRvmkfsECxlxM8BnQjlXVc",
  resolveLinks: true,
});

const convertPostEntry = (entry) => {
  const res = JSON.stringify({
    ...entry.fields,
    createdAt: entry.sys.createdAt,
    id: entry.sys.id,
  });
  return res;
};

export const getPostsImpl = () =>
  client
    .getEntries({ content_type: "post" })
    .then((entries) => entries.items.map(convertPostEntry));

export const getWorksImpl = () =>
  client.getEntries({ content_type: "work" }).then((res) => {
    const assetMap = res.includes.Asset.reduce((acc, cur) => {
      acc[cur.sys.id] = cur;
      return acc;
    }, {});

    return res.items.map((item) => {
      const res = JSON.stringify({
        ...item.fields,
        createdAt: item.sys.createdAt,
        id: item.sys.id,
        thumbnail: assetMap[item.fields.thumbnail.sys.id].fields.file.url,
        tags: item.fields.tags ?? [],
      });
      return res;
    });
  });

export const getPostInfoImpl = (id) => () =>
  client.getEntry(id).then(convertPostEntry);

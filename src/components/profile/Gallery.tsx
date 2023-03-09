interface GalleryProps {
  id: string;
}

export default function Gallery(props: GalleryProps) {
  return (
    <>
      <h1>Gallery</h1>
      <h2>{props.id}</h2>
    </>
  );
}

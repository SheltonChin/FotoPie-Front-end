interface CollectionProps {
  id: string;
}

export default function Collection(props: CollectionProps) {
  // useEffect(() => {

  return (
    <>
      <h1>Collection</h1>
      <h2>{props.id}</h2>
    </>
  );
}

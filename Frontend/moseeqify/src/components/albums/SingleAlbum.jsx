import React, { useState, useEffect } from "react";
import { useParams } from "react-router-dom";
import axios from "axios";
import Song from "../Song";

const SingleAlbum = () => {
  const { albumId } = useParams();
  const [album, setAlbum] = useState(null);

  useEffect(() => {
    const fetchAlbum = async () => {
      try {
        const response = await axios.get(
          `http://localhost:5000/albums/${albumId}`
        );
        setAlbum(response.data);
      } catch (error) {
        console.error("Error fetching album:", error);
      }
    };

    fetchAlbum();
  }, [albumId]);

  if (!album) {
    return <div>Loading...</div>;
  }

  return (
    <div className="container mx-auto bg-black flex flex-col mb-24 mt-16">
      <img
        src={album.cover_image_link}
        alt={album.name}
        className="w-56 h-auto rounded-lg mb-4"
      />
      <h1 className="text-3xl font-bold text-white mb-4">{album.name}</h1>
      <h1 className="text-xl font-bold text-white mb-4">{album.artist}</h1>

      <h2 className="text-xl font-bold text-white mb-2">Songs</h2>
      <div className="flex flex-col space-y-2">
        {album.songs.map((song) => (
          <Song
            key={song.id}
            title={song.title}
            artist={song.artist}
            url={song.url}
            songId={song.id}
          />
        ))}
      </div>
    </div>
  );
};

export default SingleAlbum;

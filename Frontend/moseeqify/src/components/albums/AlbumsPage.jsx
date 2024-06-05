import React, { useState, useEffect } from "react";
import axios from "axios";
import Navbar from "../navbar/Navbar";
import Album from "./Album";

const AlbumsPage = () => {
  const [albums, setAlbums] = useState([]);

  useEffect(() => {
    const fetchAlbums = async () => {
      try {
        const response = await axios.get("http://localhost:5000/albums");
        setAlbums(response.data);
        console.log(response.data);
      } catch (error) {
        console.error("Error fetching albums:", error);
      }
    };

    fetchAlbums();
  }, []);

  return (
    <>
      <div className="container pb-24 mx-auto bg-black flex flex-col mt-16">
        <h1 className="text-3xl font-bold text-white mb-4">Albums</h1>
        <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4">
          {albums.map((album) => (
            <Album key={album.id} album={album} />
          ))}
        </div>
      </div>
    </>
  );
};

export default AlbumsPage;

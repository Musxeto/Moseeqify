import React, { useState, useEffect } from "react";
import axios from "axios";
import Navbar from "../navbar/Navbar";

const SongsPage = () => {
  const [songs, setSongs] = useState([]);

  useEffect(() => {
    const fetchSongs = async () => {
      try {
        const response = await axios.get("http://localhost:5000/songs");
        setSongs(response.data);
      } catch (error) {
        console.error("Error fetching songs:", error);
      }
    };

    fetchSongs();
  }, []);

  return (
    <>
      <Navbar />
      <div className="container mx-auto bg-black flex flex-col mt-16">
        <h1 className="text-3xl font-bold text-white mb-4">Songs</h1>
        <ul className="text-white">
          {songs.map((song) => (
            <li key={song.id}>
              {song.title} - {song.artist}
            </li>
          ))}
        </ul>
      </div>
    </>
  );
};

export default SongsPage;

import React, { useState } from "react";
import axios from "axios";

const CreatePlaylistForm = ({ onPlaylistCreated }) => {
  const [name, setName] = useState("");

  const handleSubmit = (event) => {
    event.preventDefault();
    axios
      .post("/playlists", { name })
      .then((response) => {
        onPlaylistCreated(response.data);
        setName("");
      })
      .catch((error) => {
        console.error("There was an error creating the playlist!", error);
      });
  };

  return (
    <form onSubmit={handleSubmit}>
      <input
        type="text"
        value={name}
        onChange={(e) => setName(e.target.value)}
        placeholder="New Playlist Name"
        required
      />
      <button type="submit">Create Playlist</button>
    </form>
  );
};

export default CreatePlaylistForm;

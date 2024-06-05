import React from "react";

const PlaylistItem = ({ playlist }) => {
  return (
    <div>
      <h2>{playlist.name}</h2>
      <p>Created by: {playlist.username}</p>
      <ul>
        {playlist.songs.length > 0 ? (
          playlist.songs.map((song) => (
            <li key={song.id}>
              {song.title} by {song.artist}
            </li>
          ))
        ) : (
          <li>No songs in this playlist</li>
        )}
      </ul>
    </div>
  );
};

export default PlaylistItem;

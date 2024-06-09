import React, { useState, useEffect } from "react";
import axios from "axios";

const AddSongToPlaylistModal = ({ isOpen, onClose, songId }) => {
  const [selectedPlaylistId, setSelectedPlaylistId] = useState("");
  const [playlists, setPlaylists] = useState([]);

  useEffect(() => {
    const fetchPlaylists = async () => {
      try {
        const response = await axios.get("http://localhost:5000/playlists");
        setPlaylists(response.data);
      } catch (error) {
        console.error("Error fetching playlists:", error);
      }
    };

    if (isOpen) {
      fetchPlaylists();
    }
  }, [isOpen]);

  const handleAddToPlaylist = async () => {
    try {
      await axios.post(
        `http://localhost:5000/playlists/${selectedPlaylistId}/add-song/${songId}`
      );
      onClose();
    } catch (error) {
      console.error("Error adding song to playlist:", error);
    }
  };

  if (!isOpen) return null;

  return (
    <div className="fixed inset-0 flex items-center justify-center bg-black bg-opacity-50">
      <div className="bg-white p-6 rounded-lg shadow-lg">
        <h2 className="text-2xl font-bold mb-4">Add Song to Playlist</h2>
        <select
          className="w-full p-2 border border-gray-300 rounded mb-4"
          value={selectedPlaylistId}
          onChange={(e) => setSelectedPlaylistId(e.target.value)}
        >
          <option value="">Select Playlist</option>
          {playlists.length > 0 ? (
            playlists.map((playlist) => (
              <option key={playlist.id} value={playlist.id}>
                {playlist.name}
              </option>
            ))
          ) : (
            <option disabled>No playlists available</option>
          )}
        </select>
        <div className="flex justify-end">
          <button
            type="button"
            className="bg-gray-500 text-white px-4 py-2 rounded mr-2"
            onClick={onClose}
          >
            Cancel
          </button>
          <button
            type="button"
            className="bg-blue-500 text-white px-4 py-2 rounded"
            onClick={handleAddToPlaylist}
            disabled={!selectedPlaylistId}
          >
            Add
          </button>
        </div>
      </div>
    </div>
  );
};

export default AddSongToPlaylistModal;

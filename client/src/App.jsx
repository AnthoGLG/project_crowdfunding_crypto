// Import de React et des composants React Router DOM
import React from 'react';
import { Route, Routes } from 'react-router-dom';

// Import des composants Sidebar et Navbar depuis le dossier components
import { Sidebar, Navbar } from './components';

// Import des pages Home, Profile, CreateCampaign et CampaignDetails depuis le dossier pages
import { CampaignDetails, CreateCampaign, Home, Profile } from './pages';

// Définition du composant App qui rend l'ensemble de l'application
const App = () => {
  return (
    // Conteneur principal qui utilise le système de grille de Tailwind CSS pour le positionnement des éléments
    <div className="relative sm:-8 p-4 bg-[#13131a] min-h-screen flex flex-row">

      {/* Conteneur pour le composant Sidebar */}
      <div className="sm:flex hidden mr-10 relative">

        {/* Utilisation du composant Sidebar */}
        <Sidebar />
      </div>

      {/* Conteneur pour le reste de l'application */}
      <div className="flex-1 max-sm:w-full max-w-[1280px] mx-auto sm:pr-5">

        {/* Utilisation du composant Navbar */}
        <Navbar />

         {/* Utilisation du composant Routes pour définir les différentes routes de l'application */}
        <Routes>

          {/* Route pour la page d'accueil */}
          <Route path="/" element={<Home />} />

          {/* Route pour la page de profil */}
          <Route path="/profile" element={<Profile />} />

          {/* Route pour la page de création de campagne */}
          <Route path="/create-campaign" element={<CreateCampaign />} />

          {/* Route pour la page de détails de campagne, avec l'identifiant de la campagne passé en paramètre */}
          <Route path="/campaign-details/:id" element={<CampaignDetails />} />
        </Routes>
      </div>
    </div>
  )
}

// Export du composant App
export default App
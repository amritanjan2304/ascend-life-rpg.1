import jwt from 'jsonwebtoken';
import type { Request, Response, NextFunction } from 'express';
import dotenv from 'dotenv'; dotenv.config();
const secret=process.env.JWT_SECRET||'dev-secret-change-me';
export function signToken(userId:string){return jwt.sign({sub:userId},secret,{expiresIn:'7d'});}
export function auth(req:Request,res:Response,next:NextFunction){const h=req.headers.authorization;if(!h?.startsWith('Bearer '))return res.status(401).json({message:'Authentication required'});try{const p=jwt.verify(h.slice(7),secret) as jwt.JwtPayload;(req as any).userId=p.sub;next()}catch{return res.status(401).json({message:'Invalid or expired token'})}}
